# Elastic Stack (EFK) Demo Stand

## Architecture
![Architecture](jpg/Architecture.jpg)

## Spinning up the cluster:
```
docker-compose up -d
```

## Services:
- Tomcat: 8080
- Kibana: 5601
- Elasticsearch: 9200
- cAdvisor: 9104

## Testing Scenario

### 1. Deploy sample.war into tomcat
```bash
cd target
wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
```

### 2. Check Kibana Dashboard

### 3. Remove sample.war
```bash
cd target
rm -rf sample.war sample/
```

### 4. Check Kibana Dashboard
