(
  base=https://secure.digitalblasphemy.com/content/zips
  path=$HOME/Downloads
  for res in `cut -d ' ' -f 1 <$HOME/etc/wallpaper/res.list`; do
    file=$path/$res.zip
    url=$base/$res.zip
    case `file -b --mime-type "$file"` in
      application/zip) ;;
      *) touch -r /etc/epoch "$file" ;;
    esac
    echo fetch "${file##*/}" "($url)" 1>&2
    pass2netrc web/com.digitalblasphemy \
    | curl \
      --netrc-file /dev/fd/0 \
      --output "$file" \
      --remote-time \
      --time-cond "$file" \
      --url "$url"
  done
)
