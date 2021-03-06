package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.User;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class Player extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYERID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Player.playerId", "playerId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var playerId:int;

		/**
		 *  @private
		 */
		public static const USER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("communication.protos.Player.user", "user", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.User; });

		private var user$field:communication.protos.User;

		public function clearUser():void {
			user$field = null;
		}

		public function get hasUser():Boolean {
			return user$field != null;
		}

		public function set user(value:communication.protos.User):void {
			user$field = value;
		}

		public function get user():communication.protos.User {
			return user$field;
		}

		/**
		 *  @private
		 */
		public static const COLOR:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Player.color", "color", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var color:int;

		/**
		 *  @private
		 */
		public static const ISPLAYEDMOVE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("communication.protos.Player.isPlayedMove", "isPlayedMove", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var isPlayedMove:Boolean;

		/**
		 *  @private
		 */
		public static const CARDCOUNT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Player.cardCount", "cardCount", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		public var cardCount:int;

		/**
		 *  @private
		 */
		public static const NUMBEROFREINFORCMENTS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.Player.numberOfReinforcments", "numberOfReinforcments", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var numberOfReinforcments$field:int;

		private var hasField$0:uint = 0;

		public function clearNumberOfReinforcments():void {
			hasField$0 &= 0xfffffffe;
			numberOfReinforcments$field = new int();
		}

		public function get hasNumberOfReinforcments():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set numberOfReinforcments(value:int):void {
			hasField$0 |= 0x1;
			numberOfReinforcments$field = value;
		}

		public function get numberOfReinforcments():int {
			return numberOfReinforcments$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.playerId);
			if (hasUser) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, user$field);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.color);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, this.isPlayedMove);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.cardCount);
			if (hasNumberOfReinforcments) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, numberOfReinforcments$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var playerId$count:uint = 0;
			var user$count:uint = 0;
			var color$count:uint = 0;
			var isPlayedMove$count:uint = 0;
			var cardCount$count:uint = 0;
			var numberOfReinforcments$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (playerId$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.playerId cannot be set twice.');
					}
					++playerId$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (user$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.user cannot be set twice.');
					}
					++user$count;
					this.user = new communication.protos.User();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.user);
					break;
				case 3:
					if (color$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.color cannot be set twice.');
					}
					++color$count;
					this.color = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (isPlayedMove$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.isPlayedMove cannot be set twice.');
					}
					++isPlayedMove$count;
					this.isPlayedMove = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 5:
					if (cardCount$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.cardCount cannot be set twice.');
					}
					++cardCount$count;
					this.cardCount = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 6:
					if (numberOfReinforcments$count != 0) {
						throw new flash.errors.IOError('Bad data format: Player.numberOfReinforcments cannot be set twice.');
					}
					++numberOfReinforcments$count;
					this.numberOfReinforcments = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
