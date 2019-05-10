
/// 首页显示选择日期
class ShowHistoryDateEvent{
  bool forceHide = false;

  ShowHistoryDateEvent();

  ShowHistoryDateEvent.hide(){
    this.forceHide = true;
  }
}