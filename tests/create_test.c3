module memcached_test @test;

import memcached;

fn void create_allocates_a_new_handle()
{
	Memcached memc = Memcached.create((Memcached)null);
	assert(memc != null);
	memc.free();
}

fn void create_matches_raw_binding()
{
	Memcached memc = memcached::memcached_create((Memcached)null);
	assert(memc != null);
	memc.free();
}
