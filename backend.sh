echo Disable default NodeJS Version Module
dnf module disable nodejs -y &>>/tmp/expense.log

echo Enable NodeJS module for V20
dnf module enable nodejs:20 -y &>>/tmp/expense.log

echo install NodeJS
dnf install nodejs -y &>>/tmp/expense.log

useradd expense &>>/tmp/expense.log
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

rm -rf /app &>>/tmp/expense.log

mkdir /app &>>/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log

cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log

systemctl daemon-reload &>>/tmp/expense.log

systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
dnf install mysql -y &>>/tmp/expense.log
mysql -h 172.31.5.50 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
