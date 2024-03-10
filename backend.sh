source common.sh


mysql_root_password=$1

#if password is not provided then we will exit
if [ -z "${mysql_root_password=$1}" ]; then
  echo Input Password is missing
  exit 1
fi

Print_Tak_Heading "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>>$LOG
Check_Status $?

Print_Tak_Heading "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>$LOG
Check_Status $?

Print_Tak_Heading "install NodeJS"
dnf install nodejs -y &>>$LOG
Check_Status $?

Print_Tak_Heading "Adding Application user"
useradd expense &>>$LOG
Check_Status $?

Print_Tak_Heading "Copy Backend Service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
Check_Status $?

Print_Tak_Heading "Clean the Old Content"
rm -rf /app &>>$LOG
Check_Status $?

Print_Tak_Heading "Creating app Directory"
mkdir /app &>>$LOG
Check_Status $?

Print_Tak_Heading "Download app Content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
Check_Status $?

Print_Tak_Heading "Extract app Content"
cd /app &>>$LOG
unzip /tmp/backend.zip &>>$LOG
Check_Status $?


Print_Tak_Heading "Download NodeJS dependencies"
cd /app &>>$LOG
npm install &>>$LOG
Check_Status $?

Print_Tak_Heading "Start backend service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
Check_Status $?

Print_Tak_Heading "Install MySql Client"
dnf install mysql -y &>>$LOG
Check_Status $?

Print_Tak_Heading "load Schema"
mysql -h 172.31.8.154 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
Check_Status $?
