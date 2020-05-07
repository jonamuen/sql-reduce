cockroach start --insecure --store=node1 --listen-addr=localhost:26257 --http-addr=localhost:8080 --join=localhost:26257,localhost:26258,localhost:26259 --background

cockroach init --insecure --host=localhost:26257
cockroach sql --insecure --execute "CREATE DATABASE test;" --host=localhost:26257
