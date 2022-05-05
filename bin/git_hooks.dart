import 'dart:core';
import 'dart:io';

import 'package:dart_git_hooks/dart_git_hooks.dart';

void main(List<String> arguments) {
  // ignore: omit_local_variable_types
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  String commitMsg = Utils.getCommitEditMsg();
  print('commit message $commitMsg');
  if (commitMsg.startsWith('fix:') ||
      commitMsg.startsWith('feat:') ||
      commitMsg.startsWith('docs:') ||
      commitMsg.startsWith('style:') ||
      commitMsg.startsWith('refactor:') ||
      commitMsg.startsWith('test:') ||
      commitMsg.startsWith('chore:')) {
    return true; // you can return true let commit go
  } else {
    print(
      'commit message 格式： `fix:`, `feat:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`, '
      '\n 参考地址：https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html',
    );
    return false;
  }
}

Future<bool> preCommit() async {
  try {
    print('dart analyze 开始分析... ${DateTime.now()}');
    //--options analysis_options.yaml lib
    ProcessResult result = await Process.run('dart', ['analyze']);
    print('dart analyze 分析中... ${result.stdout}');
    print("dart analyze 分析完成 - ${DateTime.now()} \t 返回码：${result.exitCode}");
    print('dart analyze err: ${result.stderr}');
    if ('${result.stderr}'.isNotEmpty) return false;
  } catch (e) {
    print('错误：$e');
    return false;
  }
  return true;
}
