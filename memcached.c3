module memcached;

faultdef CREATE_FAILED;

extern fn Memcached Memcached.create(self) @cname("memcached_create");

fn Memcached? make(String config)
{
	Memcached memc = memcached(config.ptr, config.len);
	if (!memc) return CREATE_FAILED~;
	return memc;
}

extern fn void Memcached.free(self) @cname("memcached_free");

extern fn ZString Memcached.strerror(self, MemcachedReturn rc) @cname("memcached_strerror");

extern fn MemcachedReturn Memcached.server_add(self, ZString hostname, ushort port) @cname("memcached_server_add");

extern fn uint Memcached.server_count(self) @cname("memcached_server_count");

extern fn MemcachedReturn Memcached.behavior_set(self, MemcachedBehavior flag, ulong data) @cname("memcached_behavior_set");
