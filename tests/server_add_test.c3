module memcached_test @test;

import memcached;

fn void server_add_adds_a_reachable_server()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL --POOL-MIN=5 --POOL-MAX=10`)!!;
	assert(memc.server_count() == 0);
	assert(memc.server_add((ZString)"host10.example.com", 11211) == MemcachedReturn.MEMCACHED_SUCCESS);
	assert(memc.server_count() == 1);
	memc.free();
}

fn void server_add_matches_raw_binding()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL --POOL-MIN=5 --POOL-MAX=10`)!!;
	assert(memcached::memcached_server_add(memc, (ZString)"host10.example.com", 11211) == MemcachedReturn.MEMCACHED_SUCCESS);
	assert(memc.server_count() == 1);
	memc.free();
}
