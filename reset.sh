docker-compose down
sudo git checkout -- config/*
sudo git checkout -- data/*
sudo git checkout -- gitlab-runner/*
sudo git checkout -- logs/*
#sudo rm config data gitlab-runner logs -Rf
#mkdir config data gitlab-runner logs
docker-compose up -d