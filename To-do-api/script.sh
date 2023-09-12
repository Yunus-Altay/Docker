curl http://<ec2-host-name>/todos
curl http://<ec2-host-name>/todos/3
curl -H "Content-Type: application/json" -X POST -d '{"title":"Get some AIR", "description":"REST in Peace"}' \
http://<ec2-host-name>/todos
curl -H "Content-Type: application/json" -X DELETE http://<ec2-host-name>/todos/1
