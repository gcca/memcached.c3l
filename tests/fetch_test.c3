module memcached_test @test;

import memcached, libc;

fn void fetch_without_mget_returns_no_value()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	char[memcached::MEMCACHED_MAX_KEY] return_key;
	usz return_key_length;
	usz return_value_length;
	uint flags;
	MemcachedReturn rc;
	char* return_value = memc.fetch(&return_key, &return_key_length, &return_value_length, &flags, &rc);
	assert(return_value == null);
	if (return_value) libc::free(return_value);
	memc.free();
}

fn void fetch_matches_raw_binding()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	char[memcached::MEMCACHED_MAX_KEY] return_key;
	usz return_key_length;
	usz return_value_length;
	uint flags;
	MemcachedReturn rc;
	char* return_value = memcached::memcached_fetch(memc, &return_key, &return_key_length, &return_value_length, &flags, &rc);
	assert(return_value == null);
	if (return_value) libc::free(return_value);
	memc.free();
}
