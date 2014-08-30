package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.Card;
	import communication.protos.Alliance;
	import communication.protos.LightGameContext;
	import communication.protos.Territory;
	import communication.protos.Command;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class GameContext extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const LIGHTGAMECONTEXT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("communication.protos.GameContext.lightGameContext", "lightGameContext", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.LightGameContext; });

		public var lightGameContext:communication.protos.LightGameContext;

		/**
		 *  @private
		 */
		public static const ISPHASECOMMITED:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("communication.protos.GameContext.isPhaseCommited", "isPhaseCommited", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var isPhaseCommited:Boolean;

		/**
		 *  @private
		 */
		public static const TERRITORIES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.GameContext.territories", "territories", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Territory; });

		[ArrayElementType("communication.protos.Territory")]
		public var territories:Array = [];

		/**
		 *  @private
		 */
		public static const ALLIANCES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.GameContext.alliances", "alliances", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Alliance; });

		[ArrayElementType("communication.protos.Alliance")]
		public var alliances:Array = [];

		/**
		 *  @private
		 */
		public static const PENDINGCOMANDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.GameContext.pendingComands", "pendingComands", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Command; });

		[ArrayElementType("communication.protos.Command")]
		public var pendingComands:Array = [];

		/**
		 *  @private
		 */
		public static const MYCARDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.GameContext.myCards", "myCards", (6 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.Card; });

		[ArrayElementType("communication.protos.Card")]
		public var myCards:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.lightGameContext);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, this.isPhaseCommited);
			for (var territories$index:uint = 0; territories$index < this.territories.length; ++territories$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.territories[territories$index]);
			}
			for (var alliances$index:uint = 0; alliances$index < this.alliances.length; ++alliances$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.alliances[alliances$index]);
			}
			for (var pendingComands$index:uint = 0; pendingComands$index < this.pendingComands.length; ++pendingComands$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.pendingComands[pendingComands$index]);
			}
			for (var myCards$index:uint = 0; myCards$index < this.myCards.length; ++myCards$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.myCards[myCards$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var lightGameContext$count:uint = 0;
			var isPhaseCommited$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (lightGameContext$count != 0) {
						throw new flash.errors.IOError('Bad data format: GameContext.lightGameContext cannot be set twice.');
					}
					++lightGameContext$count;
					this.lightGameContext = new communication.protos.LightGameContext();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.lightGameContext);
					break;
				case 2:
					if (isPhaseCommited$count != 0) {
						throw new flash.errors.IOError('Bad data format: GameContext.isPhaseCommited cannot be set twice.');
					}
					++isPhaseCommited$count;
					this.isPhaseCommited = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 3:
					this.territories.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Territory()));
					break;
				case 4:
					this.alliances.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Alliance()));
					break;
				case 5:
					this.pendingComands.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Command()));
					break;
				case 6:
					this.myCards.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.Card()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
