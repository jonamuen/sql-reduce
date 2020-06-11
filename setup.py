import setuptools

with open('README.md') as f:
    long_desc = f.read()

setuptools.setup(
    name='SQL-Reduce',
    version='0.2',
    author='Jonas Muentener',
    description='A reduction tool for SQL',
    long_description=long_desc,
    long_description_content_type='text/markdown',
    url='https://github.com/jonamuen/sql-reduce',
    packages=setuptools.find_packages(),
    classifiers=[
        'Programming Language :: Python :: 3'
    ],
    python_requires='>=3.8'
)