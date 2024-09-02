## **Overview of Docker Swarm and Overlay Networking**

**Docker Swarm** is Docker’s native clustering and orchestration tool. It allows you to manage a cluster of Docker Engines (nodes) as a single virtual system. Swarm enables features like service scaling, desired state management, and load balancing.

**Overlay Networking** in Docker Swarm allows containers running on different Docker hosts (nodes) to communicate securely. It creates a virtual network that spans across all nodes in the swarm, enabling seamless inter-container communication.

---

## **Detailed Breakdown**

### **1. Initializing Docker Swarm on `userver` (Manager Node)**

**Command Executed:**
```bash
sudo docker swarm init --advertise-addr 192.168.1.111
```

**Explanation:**
- **`docker swarm init`**: Initializes the current node (`userver`) as the manager of a new Docker Swarm.
- **`--advertise-addr 192.168.1.111`**: Specifies the IP address that the manager node will advertise to other nodes for communication. This is crucial in environments with multiple network interfaces to ensure nodes communicate over the correct network.

**Outcome:**
- Swarm is successfully initialized.
- `userver` becomes the **manager node** with a unique Swarm ID.
- A **join token** is generated for worker nodes to join the swarm.

---

### **2. Joining `uworker1` to the Swarm as a Worker Node**

**Command Executed on `uworker1`:**
```bash
sudo docker swarm join --token SWMTKN-1-4l2p01hd7krwt5c96901mvpgqg8ryxbqnh0bfi7cyw0s7b2ha4-f5h16tc279rerl4t2k3mhf090 192.168.1.111:2377
```

**Explanation:**
- **`docker swarm join`**: Command used by a node (`uworker1`) to join an existing swarm.
- **`--token`**: A unique token provided by the manager node (`userver`) that authenticates the joining node as a worker.
- **`192.168.1.111:2377`**: The address and port of the manager node that the worker node connects to for joining the swarm.

**Outcome:**
- `uworker1` successfully joins the swarm as a **worker node**.
- Now, the swarm consists of one manager (`userver`) and one worker (`uworker1`).

---

### **3. Verifying Swarm Nodes on `userver`**

**Command Executed on `userver`:**
```bash
sudo docker node ls
```

**Explanation:**
- **`docker node ls`**: Lists all nodes that are part of the swarm, showing their roles, statuses, and other relevant information.

**Outcome:**
- Displays both `userver` (manager) and `uworker1` (worker) as active nodes in the swarm.
  
  ```
  ID                            HOSTNAME           STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
  01tkaufyy5bnx2wxugj9won7u     debian-user-wkr1   Ready     Active                          27.2.0
  vblrf21agawlmg36gy8qb1c3a *   userver            Ready     Active         Leader           26.1.4
  ```

---

### **4. Creating Overlay Networks**

**Commands Executed on `userver`:**
```bash
sudo docker network create -d overlay data_eng_swarm_network
sudo docker network create -d overlay overnet
```

**Explanation:**
- **`docker network create`**: Creates a new Docker network.
- **`-d overlay`**: Specifies that the network driver is `overlay`, enabling multi-host networking across the swarm.
- **`data_eng_swarm_network` & `overnet`**: Names of the newly created overlay networks.

**Outcome:**
- **`data_eng_swarm_network`** and **`overnet`** are successfully created as overlay networks.
- These networks span across all nodes in the swarm, allowing containers on different nodes to communicate as if they were on the same host.

**Verification:**
```bash
sudo docker network ls
```
Shows the newly created overlay networks:
```
NETWORK ID     NAME                     DRIVER    SCOPE
...
5f6118347312   docker_gwbridge          bridge    local
...
a1vrthsuvrjk   ingress                  overlay   swarm
...
```

---

### **5. Creating a Docker Service Connected to an Overlay Network**

**Command Executed on `userver`:**
```bash
sudo docker service create --name myservice --network overnet --replicas 2 alpine sleep 1d
```

**Explanation:**
- **`docker service create`**: Deploys a new service in the swarm.
- **`--name myservice`**: Names the service `myservice`.
- **`--network overnet`**: Connects the service to the `overnet` overlay network, enabling inter-container communication across nodes.
- **`--replicas 2`**: Specifies that two instances (replicas) of the service should run.
- **`alpine sleep 1d`**: Uses the `alpine` image to run a simple command (`sleep 1 day`) as the service's task.

**Outcome:**
- The service `myservice` is created with **2 replicas** running across the swarm.
- Both replicas are connected to the `overnet` overlay network, allowing them to communicate with each other seamlessly, regardless of the node they are running on.

**Verification:**
```bash
sudo docker service ls
```
Displays the running service:
```
ID             NAME        MODE         REPLICAS   IMAGE           PORTS
yri7y1s6ndqj   myservice   replicated   2/2        alpine:latest
```

---

### **6. Inspecting the Overlay Network**

**Command Executed on `userver`:**
```bash
sudo docker network inspect overnet
```

**Explanation:**
- **`docker network inspect`**: Provides detailed information about a specified network.
- **`overnet`**: The name of the overlay network being inspected.

**Outcome:**
- Detailed JSON output shows the configuration of `overnet`, including subnet details, connected containers, and peer nodes.
  
  ```json
  [
      {
          "Name": "overnet",
          "Id": "70lrqotip9m6ei4lm7ewfjctq",
          "Driver": "overlay",
          "Scope": "swarm",
          "Containers": {
              "b161e5b5f757a39d4ab0e3a51f03947a8c73a2d28cda3353ac8e9a353d15400e": {
                  "Name": "myservice.2.e2bwh2ee5niyaob8xivwhje38",
                  "IPv4Address": "10.0.2.4/24"
              },
              "lb-overnet": {
                  "Name": "overnet-endpoint",
                  "IPv4Address": "10.0.2.6/24"
              }
          },
          "Peers": [
              {
                  "Name": "d836e7b0a84a",
                  "IP": "192.168.1.111"
              },
              {
                  "Name": "db2935782e15",
                  "IP": "192.168.1.123"
              }
          ]
      }
  ]
  ```

- **Key Points:**
  - **Containers**: Lists containers connected to the `overnet` network along with their IP addresses.
  - **Peers**: Shows the swarm nodes participating in the overlay network.

---

### **7. Interacting with the Service Containers**

**Commands Executed on `uworker1`:**
```bash
sudo docker ps
```
**Outcome:**
- Lists running containers, including `myservice` replicas and `portainer`.

```plaintext
CONTAINER ID   IMAGE                    COMMAND        CREATED         STATUS         PORTS                      NAMES
00a043f1d936   alpine:latest            "sleep 1d"     3 minutes ago   Up 2 minutes   myservice.1.yzvjxxc7uo3h0cs6mdjennd5g
a145693fe1f2   portainer/portainer-ce   "/portainer"   9 hours ago     Up 4 hours     9000/tcp, 9443/tcp, ...   portainer
```

**Executing a Command Inside a Container:**
```bash
sudo docker exec -it 00a043f1d936 sh
```

**Inside the Container:**
```bash
/ # ping 10.0.2.4
PING 10.0.2.4 (10.0.2.4): 56 data bytes
64 bytes from 10.0.2.4: seq=0 ttl=64 time=0.865 ms
...
```

**Explanation:**
- **`docker exec -it <CONTAINER_ID> sh`**: Opens an interactive shell inside the specified container.
- **`ping 10.0.2.4`**: Tests connectivity to another container within the overlay network (`overnet`).

**Outcome:**
- Successful ping responses indicate that containers across different nodes can communicate over the `overnet` overlay network seamlessly.

---

## **Summary of Successful Operations**

1. **Swarm Initialization (`userver` as Manager):**
   - Enabled clustering capabilities.
   - Generated tokens for node joining.

2. **Worker Node Join (`uworker1`):**
   - Expanded the swarm with additional compute resources.

3. **Overlay Network Creation (`overnet` and `data_eng_swarm_network`):**
   - Established multi-host networks for container communication.
   - Ensured containers on different nodes can interact as if on the same local network.

4. **Service Deployment (`myservice`):**
   - Launched a replicated service across the swarm.
   - Utilized the overlay network for inter-container communication.

5. **Network Inspection and Validation:**
   - Verified network configurations and connected containers.
   - Confirmed successful communication between containers on different nodes.

---

## **Key Takeaways**

- **Docker Swarm** simplifies container orchestration by managing a cluster of Docker nodes, handling tasks like load balancing, scaling, and desired state management.

- **Overlay Networks** are essential in a swarm for enabling secure and efficient communication between containers across different nodes without manual network configurations.

- **Service Management** in Swarm allows you to deploy, scale, and manage containerized applications seamlessly across the entire cluster.

- **Network Inspection Tools** (`docker network inspect`) provide visibility into how containers are connected and communicating within the swarm, aiding in troubleshooting and optimization.





userver commands
```bash
userver@userver:~$ sudo docker network ls
[sudo] password for userver:
NETWORK ID     NAME                DRIVER    SCOPE
df7994e555f8   bridge              bridge    local
0705a0bc6b2c   data_eng_network    bridge    local
33db8e6cc2d5   host                host      local
83099b9ab44e   memos_default       bridge    local
50edd940e9e5   none                null      local
f062181cd938   portainer_default   bridge    local
248bebfb7cc0   syncthing_default   bridge    local



userver@userver:~$ sudo docker swarm init --advertise-addr 192.168.1.111
Swarm initialized: current node (vblrf21agawlmg36gy8qb1c3a) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-4l2p01hd7krwt5c96901mvpgqg8ryxbqnh0bfi7cyw0s7b2ha4-f5h16tc279rerl4t2k3mhf090 192.168.1.111:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.



userver@userver:~$ sudo docker node ls
ID                            HOSTNAME           STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
01tkaufyy5bnx2wxugj9won7u     debian-user-wkr1   Ready     Active                          27.2.0
vblrf21agawlmg36gy8qb1c3a *   userver            Ready     Active         Leader           26.1.4




userver@userver:~$ sudo docker network ls
NETWORK ID     NAME                DRIVER    SCOPE
df7994e555f8   bridge              bridge    local
0705a0bc6b2c   data_eng_network    bridge    local
5f6118347312   docker_gwbridge     bridge    local
33db8e6cc2d5   host                host      local
a1vrthsuvrjk   ingress             overlay   swarm
83099b9ab44e   memos_default       bridge    local
50edd940e9e5   none                null      local
f062181cd938   portainer_default   bridge    local
248bebfb7cc0   syncthing_default   bridge    local




userver@userver:~$ sudo docker network create -d overlay overnet
70lrqotip9m6ei4lm7ewfjctq



userver@userver:~$ sudo docker service create --name myservice --network overnet --replicas 2 alpine sleep 1d
yri7y1s6ndqjb55wt6zakvdra
overall progress: 2 out of 2 tasks
1/2: running   [==================================================>]
2/2: running   [==================================================>]
verify: Service yri7y1s6ndqjb55wt6zakvdra converged



userver@userver:~$ sudo docker service ls
ID             NAME        MODE         REPLICAS   IMAGE           PORTS
yri7y1s6ndqj   myservice   replicated   2/2        alpine:latest


userver@userver:~$ sudo docker service ps myservice
ID             NAME          IMAGE           NODE               DESIRED STATE   CURRENT STATE            ERROR     PORTS
yzvjxxc7uo3h   myservice.1   alpine:latest   debian-user-wkr1   Running         Running 56 seconds ago
e2bwh2ee5niy   myservice.2   alpine:latest   userver 



userver@userver:~$ sudo docker network inspect overnet
[
    {
        "Name": "overnet",
        "Id": "70lrqotip9m6ei4lm7ewfjctq",
        "Created": "2024-09-02T16:24:22.795596221Z",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "10.0.2.0/24",
                    "Gateway": "10.0.2.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "b161e5b5f757a39d4ab0e3a51f03947a8c73a2d28cda3353ac8e9a353d15400e": {
                "Name": "myservice.2.e2bwh2ee5niyaob8xivwhje38",
                "EndpointID": "6d94f786c31edad17cb7480357952713e588ddcf6c0bec6d09829c625ebcca52",
                "MacAddress": "02:42:0a:00:02:04",
                "IPv4Address": "10.0.2.4/24",
                "IPv6Address": ""
            },
            "lb-overnet": {
                "Name": "overnet-endpoint",
                "EndpointID": "aa0ebfd4f2011adf57c8516d783712118c358adbe29db6a6349fcb3d3121fe81",
                "MacAddress": "02:42:0a:00:02:06",
                "IPv4Address": "10.0.2.6/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "4098"
        },
        "Labels": {},
        "Peers": [
            {
                "Name": "d836e7b0a84a",
                "IP": "192.168.1.111"
            },
            {
                "Name": "db2935782e15",
                "IP": "192.168.1.123"
            }
        ]
    }
]

```


uworker1 cmds
```bash

uworker1@debian-user-wkr1:~$ sudo docker swarm join --token SWMTKN-1-4l2p01hd7krwt5c96901mvpgqg8ryxbqnh0bfi7cyw0s7b2ha4-f5h16tc279rerl4t2k3mhf090 192.168.1.111:2377
[sudo] password for uworker1:
This node joined a swarm as a worker.



uworker1@debian-user-wkr1:~$ sudo docker network inspect overnet
[
    {
        "Name": "overnet",
        "Id": "70lrqotip9m6ei4lm7ewfjctq",
        "Created": "2024-09-02T21:54:22.797406004+05:30",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "10.0.2.0/24",
                    "Gateway": "10.0.2.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "00a043f1d936e4f9498d4a78191e8a1e3105e67a5b9e61e8d260cefb215a7b1f": {
                "Name": "myservice.1.yzvjxxc7uo3h0cs6mdjennd5g",
                "EndpointID": "de0d38fda2a4e50b3415afc474d4354d19da9701bd7971fe6967009e1ae92c31",
                "MacAddress": "02:42:0a:00:02:03",
                "IPv4Address": "10.0.2.3/24",
                "IPv6Address": ""
            },
            "lb-overnet": {
                "Name": "overnet-endpoint",
                "EndpointID": "173b37978a81db12baef977f53157b4785eeb3c4129517fd86b0f12aeb710b3c",
                "MacAddress": "02:42:0a:00:02:05",
                "IPv4Address": "10.0.2.5/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "4098"
        },
        "Labels": {},
        "Peers": [
            {
                "Name": "db2935782e15",
                "IP": "192.168.1.123"
            },
            {
                "Name": "d836e7b0a84a",
                "IP": "192.168.1.111"
            }
        ]
    }
]



uworker1@debian-user-wkr1:~$ sudo docker ps
CONTAINER ID   IMAGE                    COMMAND        CREATED         STATUS         PORTS
                          NAMES
00a043f1d936   alpine:latest            "sleep 1d"     3 minutes ago   Up 2 minutes
                          myservice.1.yzvjxxc7uo3h0cs6mdjennd5g
a145693fe1f2   portainer/portainer-ce   "/portainer"   9 hours ago     Up 4 hours     8000/tcp, 9443/tcp, 0.0.0.0:9000->9000/tcp, :::9000->9000/tcp   portainer



uworker1@debian-user-wkr1:~$ sudo docker exec -it 00a043f1d936 sh
/ # ping 10.0.2.4
PING 10.0.2.4 (10.0.2.4): 56 data bytes
64 bytes from 10.0.2.4: seq=0 ttl=64 time=0.865 ms
64 bytes from 10.0.2.4: seq=1 ttl=64 time=0.687 ms
64 bytes from 10.0.2.4: seq=2 ttl=64 time=0.759 ms

--- 10.0.2.4 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max = 0.687/0.801/0.903 ms
```


