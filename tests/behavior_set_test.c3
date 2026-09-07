module memcached_test @test;

import memcached;

fn void behavior_set_accepts_known_flag()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	assert(memc.behavior_set(MemcachedBehavior.MEMCACHED_BEHAVIOR_BINARY_PROTOCOL, 1) == MemcachedReturn.MEMCACHED_SUCCESS);
	memc.free();
}

fn void behavior_set_matches_raw_binding()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	assert(memcached::memcached_behavior_set(memc, MemcachedBehavior.MEMCACHED_BEHAVIOR_TCP_NODELAY, 1) == MemcachedReturn.MEMCACHED_SUCCESS);
	memc.free();
}

fn void behavior_set_accepts_every_declared_value()
{
	Memcached memc = memcached::make(`--SERVER=host10.example.com`)!!;
	for (CInt ord = 0; ord < MemcachedBehavior.MEMCACHED_BEHAVIOR_MAX.ordinal; ord++)
	{
		MemcachedReturn result = memc.behavior_set((MemcachedBehavior)ord, 1);
		assert(result.ordinal <= MemcachedReturn.MEMCACHED_MAXIMUM_RETURN.ordinal,
			"unexpected return for behavior ordinal %d: %d", ord, result.ordinal);
	}
	memc.free();
}
