# this becomes /run.sh
echo "Starting JupyterLab in $SHARED_VOL/notebooks"
. /jupyterlab/bin/activate
cd "$SHARED_VOL/notebooks" || exit

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_OPTS="notebook --no-browser --port=$JUPYTERLAB_PORT"

jupyter lab --ip=0.0.0.0 --port="$JUPYTERLAB_PORT" --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''