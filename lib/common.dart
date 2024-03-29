library common;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';
import 'dart:math';

// packageImport
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:tnd_core/tnd_core.dart';
import 'package:tnd_pkg_widget/tnd_pkg_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

// preset
import 'package:imyong_app/preset/color.dart' as COLOR;
import 'package:imyong_app/preset/path.dart' as PATH;
import 'package:imyong_app/preset/router.dart' as ROUTER;
import 'package:imyong_app/preset/header.dart' as HEADER;
import 'package:imyong_app/preset/status.dart' as STATUS;
import 'package:imyong_app/preset/image.dart' as IMAGE;
import 'package:imyong_app/preset/theme.dart' as THEME;
import 'package:imyong_app/preset/msg.dart' as MSG;
import 'package:imyong_app/preset/label.dart' as LABEL;
import 'package:imyong_app/preset/subject.dart' as SUBJECT;

// import inner packages
import 'package:imyong_app/service/lib.dart';
import 'package:imyong_app/model/lib.dart';

// global
part 'utility.dart';
part 'global.dart';
part 'root.dart';

// widgets
part 'widgets/common_widgets.dart';
part 'widgets/tile_question.dart';
part 'widgets/dialog_question_detail.dart';
// part 'widgets/bottom_navigator.dart';
part 'helper/navigator.dart';

// view
part 'view/main.dart';
part 'view/view.dart';
part 'view/splash.dart';
part 'view/home.dart';
// part 'view/tabbar.dart';
part 'view/wish.dart';
part 'view/progress_rate.dart';
part 'view/setting.dart';
part 'view/ready.dart';

// part 'view/login.dart';
// part 'view/home.dart';
// part 'view/loading.dart';

// page
part 'view/page/subject_list.dart';
part 'view/page/selected_subject.dart';
part 'view/page/question.dart';
part 'view/page/question_count.dart';


// part 'view/page/question.dart';
// part 'view/page/guest.dart';
// part 'view/page/maincategory.dart';
// part 'view/page/subcategory.dart';
// part 'view/page/type.dart';
// part 'view/page/setting.dart';
