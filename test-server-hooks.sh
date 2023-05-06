set -exuo pipefail
rm -rf java_project-root/||true
rm -rf java_project-manager-a1/||true
git config --global user.email "manager-a1@example.com"
git config --global user.name "manager-a1"
git clone http://manager-a1:password123456%40@localhost:8080/my-organization/my-departament/team-a/java_project.git java_project-manager-a1
cd java_project-manager-a1
echo "" >> .gitlab-ci.yml
git add .gitlab-ci.yml
git commit -m "change file with manager-a1 user"

ERROR=$(git push 2>&1 >/dev/null||true)
echo "$ERROR"

if echo "$ERROR" | grep -q "You cannot modify .gitlab-ci.yml"; then
  echo "Test OK. User manager-a1 is unable to modify .gitlab-ci.yml due to server hook configuration."
else
  echo "Test ERROR. User manager-a1 should not be able to modify .gitlab-ci.yml due to server hook configuration."
fi

git config --global user.email "root@example.com"
git config --global user.name "root"
git clone http://root:password123456%40@localhost:8080/my-organization/my-departament/team-a/java_project.git java_project-root
cd java_project-root
echo "" >> .gitlab-ci.yml
git add .gitlab-ci.yml
git commit -m "change file with root user"
git push
if [ $? -eq 0 ]; then
  echo "Test OK. The root user is able to update the .gitlab-ci.yml file."
else
  echo "Test ERROR. User root should not be able to modify .gitlab-ci.yml due to server hook configuration."
fi

cd ..
rm -rf java_project-root/||true
rm -rf java_project-manager-a1/||true
