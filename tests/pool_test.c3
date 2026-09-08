module memcached_test @test;

import memcached;

fn void pool_returns_live_handle()
{
	MemcachedPool p = memcached::pool(
		`--SERVER=host10.example.com --SERVER=host11.example.com --SERVER=host10.example.com`
	)!!;
	assert(p != null, "expected a live pool");
	p.destroy();
}

fn void pool_matches_raw_binding()
{
	String config = `--SERVER=host10.example.com`;
	MemcachedPool p = memcached::memcached_pool(config.ptr, config.len);
	assert(p != null, "raw memcached_pool() should return a handle");
	memcached::memcached_pool_destroy(p);
}

fn void pool_pop_push_round_trip()
{
	MemcachedPool p = memcached::pool(`--SERVER=host10.example.com`)!!;
	MemcachedReturn rc;
	Memcached memc = p.pop(false, &rc);
	assert(memc != null, "pop should yield a client");
	assert(rc == MemcachedReturn.MEMCACHED_SUCCESS);
	assert(p.push(memc) == MemcachedReturn.MEMCACHED_SUCCESS);
	p.destroy();
}

fn void pool_pop_push_match_raw_binding()
{
	MemcachedPool p = memcached::pool(`--SERVER=host10.example.com`)!!;
	MemcachedReturn rc;
	Memcached memc = memcached::memcached_pool_pop(p, false, &rc);
	assert(memc != null);
	assert(rc == MemcachedReturn.MEMCACHED_SUCCESS);
	assert(memcached::memcached_pool_push(p, memc) == MemcachedReturn.MEMCACHED_SUCCESS);
	p.destroy();
}

fn void pool_rejects_unknown_option()
{
	MemcachedPool? p = memcached::pool("--NOT-AN-OPTION");
	assert(@catch(p) == memcached::CREATE_FAILED);
}

fn void pool_destroy_returns_null_when_empty()
{
	MemcachedPool p = memcached::pool(`--SERVER=host10.example.com`)!!;
	Memcached leftover = p.destroy();
	assert(leftover == null);
}
