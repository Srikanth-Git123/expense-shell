source common.sh


mysql_root_password=$1
app_dir=/app
component=backend

#if password is not provided then we will exit
if [ -z "${mysql_root_password=$1}" ]; then
  echo Input Password is missing.
  exit 1
fi

Print_Task_Heading "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>>$LOG
Check_Status $?

Print_Task_Heading "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>$LOG
Check_Status $?

Print_Task_Heading "install NodeJS"
dnf install nodejs -y &>>$LOG
Check_Status $?

Print_Task_Heading "Adding Application user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
Check_Status $?

Print_Task_Heading "Copy Backend Service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
Check_Status $?

App_PreReq

Print_Task_Heading "Download NodeJS Dependencies"
cd /app &>>$LOG
npm install &>>$LOG
Check_Status $?

Print_Task_Heading "Start backend service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
Check_Status $?

Print_Task_Heading "Install MySQL Client"
dnf install mysql -y &>>$LOG
Check_Status $?

Print_Task_Heading "load Schema"
mysql -h mysql-dev.psrikanth.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
Check_Status $?
