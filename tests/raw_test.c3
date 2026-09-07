module memcached_test @test;

import memcached;

fn void raw_bindings_round_trip()
{
	String config = `--SERVER=host10.example.com`;
	Memcached memc = memcached::memcached(config.ptr, config.len);
	assert(memc != null, "raw memcached() should return a handle");
	memcached::memcached_free(memc);
}

fn void raw_bindings_return_null_on_bad_config()
{
	String config = "--NOT-AN-OPTION";
	Memcached memc = memcached::memcached(config.ptr, config.len);
	assert(memc == null, "raw memcached() should return null");
}
