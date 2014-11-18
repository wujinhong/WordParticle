package
{
   import flash.display.BitmapData;
   
   public class Particle extends Object
   {
      
      public function Particle(param1:Number, param2:Number, param3:Number, param4:BitmapData)
      {
         super();
         xSpeed = 0;
         ySpeed = 0;
         lifeTime = 0.95;
         this.color = param3;
         this.x = param1;
         this.y = param2;
         this.bmd = param4;
         targetX = param1;
         targetY = param2;
      }
      
      private var y:Number;
      
      private var color:Number;
      
      private var targetY:Number;
      
      private var lifeTime:Number = 0.95;
      
      private var ySpeed:Number = 0;
      
      private var xSpeed:Number = 0;
      
      private var x:Number;
      
      private var bmd:BitmapData;
      
      private var targetX:Number;
      
      private function line( param1:Number, param2:Number, param3:Number, param4:Number, param5:Number ):void
      {
         var _loc6_:Number;
         var _loc7_:Number;
         var _loc8_:Number;
         var _loc9_:Number;
         var _loc10_:Number;
         var _loc11_:Number;
         var _loc13_:Number;
         if(param1 == param3 && param2 == param4)
         {
            bmd.setPixel32(param1,param2,param5);
            return;
         }
         if(param3 >= param1)
         {
            _loc8_ = param3 - param1;
            _loc10_ = 1;
         }
         else
         {
            _loc8_ = param1 - param3;
            _loc10_ = -1;
         }
         if(param4 >= param2)
         {
            _loc9_ = param4 - param2;
            _loc11_ = 1;
         }
         else
         {
            _loc9_ = param2 - param4;
            _loc11_ = -1;
         }
         _loc6_ = param1;
         _loc7_ = param2;
         if(_loc8_ >= _loc9_)
         {
            _loc9_ = _loc9_ << 1;
            _loc13_ = _loc9_ - _loc8_;
            _loc8_ = _loc8_ << 1;
            while(_loc6_ != param3)
            {
               bmd.setPixel32(_loc6_,_loc7_,param5);
               if(_loc13_ >= 0)
               {
                  _loc7_ = _loc7_ + _loc11_;
                  _loc13_ = _loc13_ - _loc8_;
               }
               _loc13_ = _loc13_ + _loc9_;
               _loc6_ = _loc6_ + _loc10_;
            }
            bmd.setPixel32(_loc6_,_loc7_,param5);
         }
         else
         {
            _loc8_ = _loc8_ << 1;
            _loc13_ = _loc8_ - _loc9_;
            _loc9_ = _loc9_ << 1;
            while(_loc7_ != param4)
            {
               bmd.setPixel32(_loc6_,_loc7_,param5);
               if(_loc13_ >= 0)
               {
                  _loc6_ = _loc6_ + _loc10_;
                  _loc13_ = _loc13_ - _loc9_;
               }
               _loc13_ = _loc13_ + _loc8_;
               _loc7_ = _loc7_ + _loc11_;
            }
            bmd.setPixel32(_loc6_,_loc7_,param5);
         }
      }
      
      public function Tick(param1:*, param2:*) : *
      {
         var _loc12_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         _loc3_ = targetX - x;
         _loc4_ = targetY - y;
         _loc5_ = param1 - x;
         _loc6_ = param2 - y;
         _loc7_ = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         _loc8_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
         if(_loc8_ + Math.random() * _loc8_ < 100)
         {
            if(_loc8_)
            {
               lifeTime = 1;
               xSpeed = xSpeed + _loc5_ / _loc8_;
               ySpeed = ySpeed + _loc6_ / _loc8_;
            }
         }
         else if(_loc7_)
         {
            xSpeed = xSpeed + _loc3_ / _loc7_;
            ySpeed = ySpeed + _loc4_ / _loc7_;
         }
         
         _loc9_ = x;
         _loc10_ = y;
         _loc12_ = xSpeed * lifeTime;
         xSpeed = xSpeed * lifeTime;
         x = x + _loc12_;
         _loc12_ = ySpeed * lifeTime;
         ySpeed = ySpeed * lifeTime;
         y = y + _loc12_;
         lifeTime = lifeTime - 0.001;
         _loc11_ = Math.abs(xSpeed) + Math.abs(ySpeed) + Math.abs(_loc3_) + Math.abs(_loc4_);
         if(_loc11_ < 5)
         {
            lifeTime = lifeTime - 0.1;
            if(_loc11_ < 1)
            {
               this.x = targetX;
               this.y = targetY;
               xSpeed = 0;
               ySpeed = 0;
            }
         }
         lifeTime = Math.max(lifeTime,0.1);
         line(Math.round(x),Math.round(y),Math.round(_loc9_),Math.round(_loc10_),color);
      }
   }
}
