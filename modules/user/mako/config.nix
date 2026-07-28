{
  # position & size
  anchor="top-right";
  margin=10;
  padding="10,14";
  width=320;
  height=100;
  max-visible=5;

  # timing
  default-timeout=5000;

  # appearance
  font="SF Pro Text 11";
  background-color="#1a1b26";
  text-color="#c6d0f5";
  border-color="#99d1db";
  border-radius=6;
  border-size=1;

  # urgency: low
  "urgency=low" = {
    border-color="#babbf1";
    default-timeout=3000;
  };

  # urgency: normal
  "urgency=normal" = {
    border-color="#99d1db";
  };

  # urgency: critical
  "urgency=critical" = {
    border-color="#e78284";
    ignore-timeout=1;
  };
}
