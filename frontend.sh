source common.sh

Print_task_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
Check_Status $?

Print_task_Heading "Copy Expense Nginx Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
Check_Status $?

Print_task_Heading "Clean Old Content"
rm -rf /usr/share/nginx/html/* &>>$LOG
Check_Status $?

Print_task_Heading "Download App Content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
Check_Status $?

Print_task_Heading "Extract App Content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOG
Check_Status $?

Print_task_Heading "Start Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
Check_Status $?
