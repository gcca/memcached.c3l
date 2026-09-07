module memcached_test @test;

import memcached;

fn void server_count_returns_configured_server_count()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com --SERVER=host11.example.com`)!!;
	assert(memc.server_count() == 2);
	assert(memcached::memcached_server_count(memc) == 2);
	memc.free();
}

fn void server_count_returns_zero_without_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL --POOL-MIN=5 --POOL-MAX=10`)!!;
	assert(memc.server_count() == 0);
	memc.free();
}
