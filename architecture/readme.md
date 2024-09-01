# Architecute I used for this course 

I have linux server on which docker is installed, I like to host my all such application there which are continusally running and I don't want my desktop to eat up lot of ram and space due to such applitions

```bash
# create one docker network
sudo docker network create --driver bridge data_eng_network

# go to mysql folder where docker-compose file is saved
sudo docker compose up -d

# access mysql
sudo docker exec -it mysql_container mysql -u admin -p
# basic commands
show databases;
use mydatabase;


```










For your setup, where you want to test Apache Spark with a cluster spanning across multiple servers and potentially a Windows laptop with WSL2, here’s a structured approach:

### **Step 1: Set Up Docker on All Machines**
1. **Server 1 (Linux Server)**:
   - Install Docker and set up one Spark master and one Spark worker node.
   
2. **Server 2 (Linux Server)**:
   - Install Docker and set up two Spark worker nodes.

3. **Windows Laptop (with WSL2)**:
   - Install WSL2 and Docker, and configure it to join the Spark cluster when needed.

### **Step 2: Create a Docker Network Across Multiple Servers**
Docker by default uses local bridge networks, which won’t span across multiple physical machines. To enable communication between Docker containers on different hosts, you can use the following methods:

#### **Option 1: Docker Swarm Mode**
1. **Initialize Docker Swarm**:
   - On **Server 1** (acting as the manager):
     ```bash
     docker swarm init --advertise-addr <Server1-IP>
     ```
   - This will output a `docker swarm join` command for worker nodes.

2. **Join Server 2 to the Swarm**:
   - On **Server 2**:
     ```bash
     docker swarm join --token <token> <Server1-IP>:2377
     ```

3. **Join Windows Laptop (Optional)**
   - On the Windows laptop (using WSL2), run the same `docker swarm join` command to join the Swarm as a worker node.

4. **Deploy Spark Services in Swarm Mode**:
   - Create a Docker Compose file to define your Spark services (Master and Workers), then deploy it to the Swarm.
   - Use the following `docker-compose.yml` as a template:
     ```yaml
     version: '3'
     services:
       spark-master:
         image: bitnami/spark:latest
         ports:
           - "8080:8080"
           - "7077:7077"
         networks:
           - spark-network
         deploy:
           replicas: 1
           placement:
             constraints: [node.role == manager]
       spark-worker:
         image: bitnami/spark:latest
         environment:
           - SPARK_MODE=worker
           - SPARK_MASTER_URL=spark://spark-master:7077
         networks:
           - spark-network
         deploy:
           replicas: 3  # Adjust based on your needs
           placement:
             constraints: [node.role == worker]
     networks:
       spark-network:
         driver: overlay
     ```
   - Deploy the stack:
     ```bash
     docker stack deploy -c docker-compose.yml spark_cluster
     ```

#### **Option 2: Docker Overlay Network without Swarm**
1. **Create an Overlay Network**:
   - On **Server 1**:
     ```bash
     docker network create --driver overlay spark-overlay
     ```

2. **Run Spark Containers on Server 1**:
   - Start the Spark master and worker containers on **Server 1**, connected to the `spark-overlay` network.

3. **Run Spark Containers on Server 2**:
   - Join Server 2 to the same overlay network and run additional worker containers connected to it:
     ```bash
     docker network connect spark-overlay <container_name>
     ```

4. **Connect the Windows Laptop**:
   - When the laptop is online, you can join it to the overlay network using the same steps, and run additional Spark worker containers if needed.

### **Step 3: Managing and Monitoring the Cluster**
- **Access Spark UI**: The Spark master’s web UI (usually on port 8080) will show all the worker nodes in the cluster.
- **Scaling Workers**: You can dynamically scale the number of worker nodes by adjusting the `replicas` field in your Docker Compose or by adding/removing containers manually.

### **Step 4: Connecting the Windows Laptop as a Part-time Worker**
- You can start the Docker container on the Windows laptop only when it's needed, and it will automatically join the cluster.

### **Conclusion**
Using Docker Swarm is probably the most straightforward way to manage a multi-node Spark cluster across different servers. It simplifies network management and service orchestration across multiple machines. The Windows laptop with WSL2 can be integrated as a part-time worker node in this setup, making it flexible for your use case.