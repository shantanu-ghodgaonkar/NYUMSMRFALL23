function result = extractDesiredPose(Tbe)
result = [atan2(Tbe(2,2)/cos(atan2(-Tbe(3,1),sqrt(Tbe(2,2)^2 + Tbe(1,1)^2))),Tbe(2,1)/cos(atan2(-Tbe(3,1),sqrt(Tbe(2,2)^2 + Tbe(1,1)^2))));
          atan2(-Tbe(3,1),sqrt(Tbe(2,2)^2 + Tbe(1,1)^2));
          atan2(Tbe(3,2)/cos(atan2(-Tbe(3,1),sqrt(Tbe(2,2)^2 + Tbe(1,1)^2))),Tbe(3,3)/cos(atan2(-Tbe(3,1),sqrt(Tbe(2,2)^2 + Tbe(1,1)^2))));
    Tbe(1,4);
    Tbe(2,4);
    Tbe(3,4)];
end