git stash
git checkout master
git pull
npm run build
pm2 stop npm
pm2 delete npm
pm2 start npm -- start