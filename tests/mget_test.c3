module memcached_test @test;

import memcached;

fn void max_key_matches_libmemcached()
{
	assert(memcached::MEMCACHED_MAX_KEY == 251);
}

fn void mget_without_servers_returns_no_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	char*[3] keys = { (char*)"fudge", (char*)"son", (char*)"food" };
	usz[3] key_length = { 5, 3, 4 };
	assert(memc.mget((char**)&keys, &key_length, 3) == MemcachedReturn.MEMCACHED_NO_SERVERS);
	memc.free();
}

fn void mget_matches_raw_binding()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	char*[3] keys = { (char*)"fudge", (char*)"son", (char*)"food" };
	usz[3] key_length = { 5, 3, 4 };
	assert(memcached::memcached_mget(memc, (char**)&keys, &key_length, 3) == MemcachedReturn.MEMCACHED_NO_SERVERS);
	memc.free();
}
