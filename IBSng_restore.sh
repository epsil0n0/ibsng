
mv $1 /var/lib/pgsql/IBSng.bak
service IBSng stop
su - postgres
dropdb IBSng
createdb IBSng
createlang plpgsql IBSng
psql IBSng < IBSng.bak
exit
