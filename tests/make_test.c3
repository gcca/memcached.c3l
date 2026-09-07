module memcached_test @test;

import memcached;

fn void make_returns_live_handle()
{
	Memcached memc = memcached::make(
		`--SERVER=host10.example.com --SERVER=host11.example.com --SERVER=host10.example.com`
	)!!;
	assert(memc != null, "expected a live handle");
	memc.free();
}

fn void make_accepts_host_with_port()
{
	Memcached memc = memcached::make(`--SERVER=localhost:11211`)!!;
	assert(memc != null);
	memc.free();
}

fn void make_accepts_options_without_servers()
{
	Memcached memc = memcached::make(`--BINARY-PROTOCOL --POOL-MIN=5 --POOL-MAX=10`)!!;
	assert(memc != null);
	memc.free();
}

fn void clients_are_independent()
{
	Memcached a = memcached::make(`--SERVER=host10.example.com`)!!;
	Memcached b = memcached::make(`--SERVER=host11.example.com`)!!;
	assert(a != b, "each make must return its own allocation");
	a.free();
	b.free();
}

fn void make_rejects_unknown_option()
{
	Memcached? memc = memcached::make("--NOT-AN-OPTION");
	assert(@catch(memc) == memcached::CREATE_FAILED);
}

fn void make_rejects_empty_config()
{
	Memcached? memc = memcached::make("");
	assert(@catch(memc) == memcached::CREATE_FAILED);
}

fn void make_rejects_blank_config()
{
	Memcached? memc = memcached::make(" ");
	assert(@catch(memc) == memcached::CREATE_FAILED);
}

fn void make_rejects_garbage()
{
	Memcached? memc = memcached::make("hello world");
	assert(@catch(memc) == memcached::CREATE_FAILED);
}

fn void make_rejects_server_without_host()
{
	Memcached? memc = memcached::make("--SERVER=");
	assert(@catch(memc) == memcached::CREATE_FAILED);
}

fn void make_honours_length_not_termination()
{
	String buffer = "--SERVER=localhost!!!GARBAGE!!!";

	Memcached? whole = memcached::make(buffer);
	assert(@catch(whole) == memcached::CREATE_FAILED, "the tail must be invalid");

	Memcached memc = memcached::make(buffer[0:18])!!;
	assert(memc != null, "the slice must be parsed on length alone");
	memc.free();
}
