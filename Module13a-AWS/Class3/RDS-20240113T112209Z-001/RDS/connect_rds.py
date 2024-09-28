import mysql.connector

def connect_and_create_db():
    connection = None
    try:
        connection = mysql.connector.connect(
            host='noob2-db.c5gs6yamcv34.us-east-1.rds.amazonaws.com',
            port=3306,
            user='admin',
            password='admin123'
        )
        if connection.is_connected():
            print("Successfully connected to the RDS instance.")
            
            cursor = connection.cursor()
            
            # Create a new database
            cursor.execute("CREATE DATABASE IF NOT EXISTS TempDB;")
            print("Database created successfully.")
            
            cursor.execute("SHOW DATABASES;")
            print(cursor.fetchall())
            
        else:
            print("Failed to connect to the RDS instance.")
    except mysql.connector.Error as e:
        print(f"Error: {e}")
    finally:
        if connection is not None and connection.is_connected():
            cursor.close()
            connection.close()
            print("Connection closed.")

if __name__ == "__main__":
    connect_and_create_db()