---
hide:
  - toc
MTPE: ModetaNiu
DATE: 2024-08-21
---

# Create a Redis instance

After accessing the Redis cache service, follow the steps below to create a Redis instance.

1. In the instance list of the Redis cache service, click the __New Instance__ button.

    ![New instance](../images/create00.png)

2. On the __Create Redis Instance__ page, after configuring __Basic Information__ , click __Next__ .

    ![Basic info](../images/create01.png)

3. After configuring __Spec Settings__ including deployment type, CPU quota, memory quota, storage class and capacity, 
   click __Next__ . Currently there are three deployment type:

    - Standalone: Standalone mode has only master node. In case of fault, data reliability cannot be guaranteed.

    - Sentinel: When the master node fails, the standby node automatically upgrades to become the master node, 
      ensuring high availability of the service.

    - Cluster : Cluster mode supports multiple standby nodes and multiple master nodes, which can meet users' demands 
      for low latency and high-performance.

    ![Spec settings](../images/create02.png)

4. Set __Service Settings__ such as username and password, and ClusterIP is used as the access method by default.

    ![Service settings](../images/create03.png)


5. After confirming that the basic information, specification configuration, and service settings are correct, 
   click __OK__ .

    ![Confirm](../images/create04.png)

6. Return to the instance list, and the screen will prompt __Instance created successfully__ . 
   The status of the newly created instance is __Not Ready__ , and it will become __Running__ after a while.

    ![Success](../images/create05.png)