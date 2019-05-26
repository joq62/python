## set the paths for a default setup
all:
	erlc -o ebin src/*.erl;
	erl -pa ebin -pa erlport/ebin -s gpio_test start -sname gpio_test;
#
# loader sim
loader_test:
	rm -rf test_ebin/* test_src/*~;
	erlc -o test_ebin test_src/*.erl
	erl -pa test_ebin -pa ebin -s test_node start -sname loader_sim

