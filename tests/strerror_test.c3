module memcached_test @test;

import memcached;

fn void strerror_describes_success()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	assert(memc.strerror(MemcachedReturn.MEMCACHED_SUCCESS).str_view() == "SUCCESS");
	memc.free();
}

fn void strerror_describes_known_failure()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	assert(memc.strerror(MemcachedReturn.MEMCACHED_NOTFOUND).str_view() == "NOT FOUND");
	memc.free();
}

fn void strerror_matches_raw_binding()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	assert(memcached::memcached_strerror(memc, MemcachedReturn.MEMCACHED_SUCCESS).str_view() == "SUCCESS");
	memc.free();
}
