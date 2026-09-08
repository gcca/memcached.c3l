module memcached_test @test;

import memcached, libc;

fn void get_without_servers_returns_no_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	String key = "foo";
	usz value_length;
	uint flags;
	MemcachedReturn rc;
	char* value = memc.get(key.ptr, key.len, &value_length, &flags, &rc);
	assert(value == null);
	assert(rc == MemcachedReturn.MEMCACHED_NO_SERVERS);
	if (value) libc::free(value);
	memc.free();
}

fn void get_matches_raw_binding()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	String key = "foo";
	usz value_length;
	uint flags;
	MemcachedReturn rc;
	char* value = memcached::memcached_get(memc, key.ptr, key.len, &value_length, &flags, &rc);
	assert(value == null);
	assert(rc == MemcachedReturn.MEMCACHED_NO_SERVERS);
	if (value) libc::free(value);
	memc.free();
}
