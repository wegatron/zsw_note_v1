# Profile

## Python

```bash
pip install memory-profiler
```

在python中加入
```python
@profile
def function_name():
    ...
```

run:
```bash
python -m memory_profile main.py
mprof run main.py
mplot
```