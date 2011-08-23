
JSLINTR_BIN=$1

if [ -f "$JSLINTR_BIN" ]; then
	sudo rm -f "$JSLINTR_BIN"
fi

sudo touch $JSLINTR_BIN
sudo chmod a+w $JSLINTR_BIN

cat "src/exports.sh" > $JSLINTR_BIN
cat "src/core.sh" >> $JSLINTR_BIN
cat "src/call_jslintr.sh" >> $JSLINTR_BIN
cat "src/main.sh" >> $JSLINTR_BIN

sudo chmod a+x $JSLINTR_BIN