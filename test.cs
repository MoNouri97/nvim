public override void _Notification(int what)
{
    if (what == NotificationEnterTree)
    {
        this.WireOnReady();
    }
}
