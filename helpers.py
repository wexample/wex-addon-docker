import yaml


def merge_docker_compose_files(src, dest):
    # Load both files as Python objects
    with open(src, 'r') as f:
        data1 = yaml.safe_load(f)
    with open(dest, 'r') as f:
        data2 = yaml.safe_load(f) or {}

    # Recursively merge the two objects
    merged_data = merge_dicts(data1, data2)

    # Write the merged data to a new file
    with open(dest, 'w') as f:
        yaml.dump(merged_data, f)


def merge_dicts(dict1, dict2):
    """
    Recursively merge two dictionaries.
    If a key exists in both dictionaries, the values are merged recursively.
    """
    result = dict1.copy()
    for key, value in dict2.items():
        if key in result and isinstance(result[key], dict) and isinstance(value, dict):
            result[key] = merge_dicts(result[key], value)
        else:
            result[key] = value
    return result
