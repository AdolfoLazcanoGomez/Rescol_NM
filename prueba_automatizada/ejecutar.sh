# Definir variables
EXECUTABLE="/home/alazcano/Rescol_NM/Rescol_NM/RESCOL"
#INPUT_FILE="/home/alazcano/Rescol_NM/Rescol_NM/Instancias/CasoRealMediano.txt"
INSTANCES_DIR="/home/alazcano/Rescol_NM/Rescol_NM/Instancias/Instancias_test"
#INSTANCE_NAME=$(basename "$INPUT_FILE" .txt) # Nombre de la instancia sin extensiÃ³n
METODO="0"
ITER_MAX="1000"
NUM_HORMIGAS="26"
EPOCAS="1"
salida_Floyd_Warshall="salida-Floyd-Warshall"

BETA0="--beta0"
ALFA="4.99"
RHO="0.3"
TAU="2.06"

USAR_ITERACIONES="--usar-iteraciones"
USAR_LIMITADOR="--usar-limitador"
VALOR_LIMITADOR="1"
SILENCE="--silence"
DIR_SALIDA="./resultados"
PREFIJO_SALIDA="nuevos"
RESCOL="--rescol"

# Ejecutar el comando 10 veces con la primera semilla fija y las siguientes secuenciales
SEMILLA_INICIAL=1234567

for INPUT_FILE in "$INSTANCES_DIR"/*.txt; do
  if [[ ! -f "$INPUT_FILE" ]]; then
    echo "No se encontraron archivos .txt en $INSTANCES_DIR"
    break
  fi

  INSTANCE_NAME=$(basename "$INPUT_FILE" .txt)
  SEMILLA=$SEMILLA_INICIAL

  echo "Procesando instancia: $INSTANCE_NAME"

  for i in {0..19}; do
    OUTPUT_FILE="${INSTANCE_NAME}_$SEMILLA.txt"
    echo "  Ejecutando con semilla: $SEMILLA, salida: $OUTPUT_FILE"
    $EXECUTABLE "$INPUT_FILE" --metodo $METODO --alfa $ALFA --rho $RHO --tau-as $TAU \
      --iter-max $ITER_MAX --num-hormigas $NUM_HORMIGAS --epocas $EPOCAS $salida_Floyd_Warshall \
      $BETA0 $USAR_ITERACIONES $USAR_LIMITADOR --valor-limitador $VALOR_LIMITADOR $SILENCE \
      --semilla $SEMILLA --dir-salida $DIR_SALIDA --prefijo-salida $PREFIJO_SALIDA $RESCOL > "$OUTPUT_FILE"
    SEMILLA=$((SEMILLA + 1))
  done
done