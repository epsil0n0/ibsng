# ibsng
IBsng 1.24 Web Based Accounting on Centos 




IBSng Accounting :

run: docker run --name ibsng -p 80:80 -d epsil0n/ibsng:1.25

web UI: http://<Your IP>/IBSng/admin user : system pass: admin

You can mount postgresql database from your host:

    Copy content of postgresql from container to host :
        docker cp ibsng:/var/lib/pgsql /<your path>/pgsql
    
    stop and remove ibsng container: 
        docker rm ibsng -f
    start container again with -v option as follow: 
        docker run --name ibsng -p 80:80 \ -v /<your pgsql on host path>/pgsql:/varlib/pgsql \ -d epsil0n/ibsng:1.25

