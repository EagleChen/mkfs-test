START=$(date +%s)
dd if=/dev/null of=$1.img bs=1M seek=$2
END=$(date +%s)
DIFF1=$(( $END - $START ))
echo $DIFF1

START=$(date +%s)
mkfs.ext4 -q -F -O "has_journal,uninit_bg" -E "lazy_itable_init=1" $1.img
END=$(date +%s)
DIFF2=$(( $END - $START ))
echo $DIFF2

mkdir -p mounts/$1
START=$(date +%s)
mount -n -o loop $1.img mounts/$1
END=$(date +%s)
DIFF3=$(( $END - $START ))
echo $DIFF3

echo $DIFF1, $DIFF2, $DIFF3 >> $3
