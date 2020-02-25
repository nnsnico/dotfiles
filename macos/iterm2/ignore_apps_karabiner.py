"""
Karabiner-Elementで一部のアプリに対して効果を無効にする記述を設定ファイル(.json)に追加するスクリプト
設定ファイルは`~/.config/karabiner/assets/complex_modifications/`配下にあります
"""

import json
from posixpath import os

# 無視したいアプリのアドレスを配列に格納
# アドレスの確認は`Karabiner-EventViewer`を使用する
target_bundle_identifiers = [
    'com.googlecode.iterm2'
]

# `~/.config/karabiner/assets/complex_modifications/`内の変更したいファイルを選択
target_json = 'vi_arrow_bkup.json'
path = os.path.expandvars('$HOME/.config/karabiner/assets/complex_modifications/')

def karabiner_escape(bundle_identifier):
    with_slash = bundle_identifier.replace('.', '\\.')
    return '^' + with_slash + '$'

def open_json():
    json_data = None
    with open(path + target_json, "r") as res:
        json_data = json.load(res)
    return json_data

# add_data内のアドレスを`bundle_identifiers`キーに追加する
# `bundle_identifiers`キーがない場合は追加する
def write_bundle_identifiers(json_data, target_bundle_identifiers):
    with open(path + target_json, "w") as res:
        # json: root#rules
        rules = json_data['rules']
        for rule in rules:
            # json: root#rules#manipulators
            manipulators = rule['manipulators']
            for manipulator in manipulators:
                # "conditions"キー、"type"、"bundle_identifiers"を追加
                if 'conditions' not in manipulator:
                    manipulator.update(
                        {
                            "conditions": [
                                {
                                    "type": "frontmost_application_unless",
                                    "bundle_identifiers": []
                                }
                            ]
                        }
                    )
                # 追加しようとしている要素がなければ"bundle_identifiers"に追加
                # json: root#rules#manipulators#conditions
                for condition in manipulator['conditions']:
                    # json: root#rules#manipulators#conditions#bundle_identifiers
                    bundle_identifiers = condition['bundle_identifiers']
                    if (condition['type'] == 'frontmost_application_unless'):
                        for target in target_bundle_identifiers:
                            # ここをいじればキーを削除するスクリプトに変えれる
                            if (target not in bundle_identifiers):
                            # if (target in bundle_identifiers):
                                bundle_identifiers.append(target)
                                # json: bundle_identifiers.remove(target)
                            else:
                                print('bundle_identifiers is alreadly exist')
                                json.dump(json_data, res, indent=2)
                                return
        print(json.dumps(json_data, indent=2))
        # エンコード(書き込みモードなのでそのまま上書き)
        json.dump(json_data, res, indent=2)

def main():
    escaped_bundle_identifiers = list(map(lambda x: karabiner_escape(x), target_bundle_identifiers))
    json = open_json()
    write_bundle_identifiers(json, escaped_bundle_identifiers)

main()

# conditionsキーをすべて削除する(テスト用)
## with open(path + target_json, "w") as res:
##    for rule in json_data['rules']:
##        manipulators = rule['manipulators']
##        for manipulator in manipulators:
##            del manipulator['conditions']
##            print(manipulator)
##    print(json.dumps(json_data, indent = 2))
##    # エンコード(書き込みモードなのでそのまま上書き)
##    json.dump(json_data, res, indent = 2)
