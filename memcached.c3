module memcached;
import libc;

faultdef CREATE_FAILED;

extern fn Memcached Memcached.create(self) @cname("memcached_create");

fn Memcached? make(String config)
{
	Memcached memc = memcached(config.ptr, config.len);
	if (!memc) return CREATE_FAILED~;
	return memc;
}

extern fn void Memcached.free(self) @cname("memcached_free");

extern fn uint Memcached.server_count(self) @cname("memcached_server_count");

extern fn MemcachedReturn Memcached.behavior_set(self, MemcachedBehavior flag, ulong data) @cname("memcached_behavior_set");

extern fn char* Memcached.get(self, char* key, usz key_length, usz* value_length, uint* flags, MemcachedReturn* error) @cname("memcached_get");

extern fn MemcachedReturn Memcached.mget(self, char** keys, usz* key_length, usz number_of_keys) @cname("memcached_mget");

extern fn char* Memcached.fetch(self, char* key, usz* key_length, usz* value_length, uint* flags, MemcachedReturn* error) @cname("memcached_fetch");

extern fn MemcachedReturn Memcached.server_add(self, ZString hostname, ushort port) @cname("memcached_server_add");

extern fn MemcachedReturn Memcached.set(self, char* key, usz key_length, char* value, usz value_length, Time_t expiration, uint flags) @cname("memcached_set");

extern fn ZString Memcached.strerror(self, MemcachedReturn rc) @cname("memcached_strerror");

fn MemcachedPool? pool(String config)
{
	MemcachedPool p = memcached_pool(config.ptr, config.len);
	if (!p) return CREATE_FAILED~;
	return p;
}

extern fn Memcached MemcachedPool.destroy(self) @cname("memcached_pool_destroy");

extern fn Memcached MemcachedPool.pop(self, bool block, MemcachedReturn* rc) @cname("memcached_pool_pop");

extern fn MemcachedReturn MemcachedPool.push(self, Memcached mmc) @cname("memcached_pool_push");
