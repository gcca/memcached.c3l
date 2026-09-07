module memcached_test @test;

import memcached;

fn void free_accepts_null()
{
	Memcached memc = (Memcached)null;
	memc.free();
}
