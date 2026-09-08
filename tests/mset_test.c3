module memcached_test @test;

import memcached, libc;

fn void mset_without_servers_returns_no_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	char*[2] keys = { (char*)"fudge", (char*)"son" };
	usz[2] key_length = { 5, 3 };
	char*[2] values = { (char*)"a", (char*)"b" };
	usz[2] value_length = { 1, 1 };
	assert(memc.mset((char**)&keys, &key_length, (char**)&values, &value_length, 2, (Time_t)0, 0) == MemcachedReturn.MEMCACHED_NO_SERVERS);
	memc.free();
}

fn void mset_rejects_empty_key_list()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL`)!!;
	assert(memc.mset(null, null, null, null, 0, (Time_t)0, 0) == MemcachedReturn.MEMCACHED_INVALID_ARGUMENTS);
	memc.free();
}
