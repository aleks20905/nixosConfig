{ pkgs, config, ... }:
{

  imports = [

    ../../services/ssh

    ../../services/factorio-headless

    ../../services/cloudeflared

    ../../services/gotth

    ../../services/curtisDashboard

    ../../services/playit-agent

    ../../services/minecraft
  ];

}
