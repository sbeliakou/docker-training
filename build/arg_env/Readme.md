# Using ARG and ENV in Dockerfile

## Scopes
- *ARG* -> Dockerfile, build phase
- *ENV* -> Build, Run phases

## Dockerfile Content

```dockerfile
ARG required_var                # expects a value
ARG var_name=default_value      # sets default ARG value
ENV foo=foo_value               # sets default ENV value
ENV bar=${var_name}             # sets default ENV value from ARG
```

## ARG Values

You can define/override ARG valued only for `build` command:

```bash
docker build \
    --build-arg required_var=value \
    .
```

## ENV Values

On the `build` phase you can override ENV values only with ARG:

```bash
docker build \
    --build-arg var_name=new_value \
    .
```

On the `run` phase you can define/override ENV variables as follows:
```bash
export F=some_value

docker run \
    -e foo=new_foo_value
    -e F \
    --env-file=env_file_name \
    image_name
```

