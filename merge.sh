#!/bin/bash
# Copyright (C) 2020 Arvind Mukund <armu30@gmail.com>
# Copyright (C) 2022 Daniele Gigantino <d.gigantino@icloud.com>
# Copyright (C) 2022 Daniele Gigantino <developerdevkrishn@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

cd $(dirname $0) # This fixes path restriction
PARTS="./parts/"

function decompress {
	xz -d "$1"
}

if test -f "./vendor.img"; then
    echo "vendor image already exists; not regenerating..."
    exit 0
fi

for part in $(find $PARTS -type f | sort); do
    echo "Concatinating $part"
	cat $part >> ./vendor.img.xz
done

decompress "./vendor.img.xz"

if test -f "./images/*"; then
    for compressed_image in ./images/*.img.xz; do
        echo "Decompressing $compressed_image"
        decompress "$compressed_image"
    done
fi

echo "[i] Merging completed."
