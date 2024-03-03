mysql_root_password=$1

echo Disable default NodeJS Version Module
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo Enable NodeJS module for V20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo install NodeJS
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo Adding Application user
useradd expense &>>/tmp/expense.log
echo $?

echo Copy Backend Service file
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

echo Clean the Old Content
rm -rf /app &>>/tmp/expense.log
echo $?

echo Creating app Directory
mkdir /app &>>/tmp/expense.log
echo $?

echo Download app Content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

echo Extract app Content
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?


echo Download NodeJS dependencies
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo Start backend service
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

echo Install MySql Client
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo load Schema
mysql -h 172.31.5.50 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?
