module memcached_test @test;

import memcached, libc;

fn void set_without_servers_returns_no_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	String key = "foo";
	String value = "value";
	assert(memc.set(key.ptr, key.len, value.ptr, value.len, (Time_t)0, 0) == MemcachedReturn.MEMCACHED_NO_SERVERS);
	memc.free();
}

fn void set_matches_raw_binding()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	String key = "foo";
	String value = "value";
	assert(memcached::memcached_set(memc, key.ptr, key.len, value.ptr, value.len, (Time_t)0, 0) == MemcachedReturn.MEMCACHED_NO_SERVERS);
	memc.free();
}
