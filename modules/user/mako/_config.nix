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
  background-color="#151515";   # base00
  text-color="#b4b4b4";         # base05
  border-color="#729a9a";       # base0C (cyan)
  border-radius=6;
  border-size=1;

  # urgency: low
  "urgency=low" = {
    border-color="#9689a3";     # base0E (purple)
    default-timeout=3000;
  };

  # urgency: normal
  "urgency=normal" = {
    border-color="#729a9a";     # base0C (cyan)
  };

  # urgency: critical
  "urgency=critical" = {
    border-color="#b46a6a";     # base08 (red)
    ignore-timeout=1;
  };
}
