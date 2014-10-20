#! /bin/bash

PGWSLIDER_DIR="$HOME/PgwSlider/"
PGWSLIDER_GIT_URL="https://github.com/Pagawa/PgwSlider.git"

LUDAK_ME_DIR="$HOME/ludak.me/"
LUDAK_ME_GIT_URL="https://github.com/NareshPS/ludak.me.git"

LUDAK_ME_JS_DIR="js/"
LUDAK_ME_CSS_DIR="css/"
LUDAK_ME_JSON_DIR="json/"

# switch to home directory
cd $HOME || (echo "No home directory. Exiting." && exit 2)

if [[ ! -d "$PGWSLIDER_DIR" ]]; then
  echo "Directory doesn't exist"
  git clone "$PGWSLIDER_GIT_URL" || (echo "Failed to sync $PGWSLIDER_DIR" && exit 2)
fi

if [[ ! -d "$LUDAK_ME_DIR" ]]; then
  git clone "$LUDAK_ME_GIT_URL" || (echo "Failed to sync $LUDAK_ME_DIR" && exit 2)
fi

# switch to pgwslider directory
cd $PGWSLIDER_DIR || (echo "Failed to find $PGWSLIDER_DIR directory" && exit 2)

# symlink js files
for js_file in "$PGWSLIDER_DIR"*.js; do
  base_filename=$(basename $js_file)
  target_filename="$LUDAK_ME_DIR""$LUDAK_ME_JS_DIR""$base_filename"

  if [[ ! -e $target_filename ]]; then
    ln -s $js_file $target_filename
  fi
done

# symlink css files
for css_file in "$PGWSLIDER_DIR"*.css; do
  base_filename=$(basename $css_file)
  target_filename="$LUDAK_ME_DIR""$LUDAK_ME_CSS_DIR""$base_filename"

  if [[ ! -e $target_filename ]]; then
    ln -s $css_file $target_filename
  fi
done

# symlink json files
for json_file in "$PGWSLIDER_DIR"*.json; do
  base_filename=$(basename $json_file)
  target_filename="$LUDAK_ME_DIR""$LUDAK_ME_JSON_DIR""$base_filename"

  if [[ ! -e $target_filename ]]; then
    ln -s $json_file $target_filename
  fi
done
